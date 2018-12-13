# @abstract
#
# Abstract superclass for all controllers in Ranked.
#
# Responses
# ---------
#
# All controller actions are documented with their routes, incoming parameters,
# and relevant possible response codes. The following response codes are
# considered universal and not documented on a per-action basis:
#
# ### Record created successfully: 201 Created
#
# This response is returned when a record is successfully created. The response
# body will contain the fields of the created record and the `Location` header
# will typically be the object's URL.
#
# ### Record updated successfully: 200 OK
#
# This response is returned when a record is successfully updated. The response
# body will contain the fields of the created record and the `Location` header
# will typically be the object's URL.
#
# ### Record deleted successfully: 204 No Content
#
# This response is returned when a record is successfully deleted.
#
# ### Bad route: 404 Not Found
#
# This response is returned for a URL that doesn't exist.
#
# ### Format not acceptable: 406 Not Acceptable
#
# This response is returned if the requested format is not permissable. (Most
# routes only accept `application/json`.)
#
# ### Validation failure: 422 Not Acceptable
#
# This response is returned when an object being saved fails validation. The
# response body will be a dictionary with a single key, `errors`, which maps to
# a nested dictionary of field names mapped to an array of error identifiers:
#
# ``` json
# {"errors": {"email": ["invalid", "taken"], "password": ["too_short"]}}
# ```

class ApplicationController < ActionController::Base
  rescue_from(ActiveRecord::RecordNotFound) do |error|
    respond_to do |format|
      format.json { render json: {error: error}, status: :not_found }
    end
  end

  # @private Overrides default responder behavior for the error behavior the
  #   front-end needs.
  class Responder < ActionController::Responder

    # @private
    def to_json
      return display_errors if has_errors?

      controller.response.status = :created if post?
      render 'show'
    end

    protected

    # @private
    def json_resource_errors
      {errors: resource.errors.details}
    end

    # @private
    def api_behavior
      raise ActionController::MissingRenderer, format unless has_renderer?

      if patch? || put?
        has_errors? ? display_errors : display(resource)
      else
        super
      end
    end
  end

  self.responder = Responder
end
