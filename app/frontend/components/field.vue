<template>
  <div class="field-error-group">
    <textarea v-if="type == 'textarea'"
              :type="type"
              :name="name"
              :value="value"
              :maxlength="maxlength"
              :required="required"
              ref="input"
              @input="updateValue($event.target.value)" />
    <p class="placeholder" :class="{'textarea-placeholder': type == 'textarea'}">{{placeholder}}</p>

    <input v-if="type != 'textarea'"
           :type="type"
           :name="name"
           :value="value"
           :placeholder="placeholder"
           :maxlength="maxlength"
           :required="required"
           ref="input"
           @input="updateValue($event.target.value)" />

    <p v-if="hasErrors">{{errorString}}</p>
  </div>
</template>

<script>
  import _ from 'lodash'

  export default {
    props: {
      value: {},
      errors: {default() { return {} }},

      type: {type: String, required: true},
      placeholder: {type: String, required: false},
      name: {type: String, required: true},
      required: {type: Boolean},
      maxlength: {type: Number}
    },

    computed: {
      attribute() {
        let [match, object, first, rest] = this.name.match(
            /^(\w+)(?:\[(\w+)\]((?:\[\w+\])*))?$/)
        return first + rest
      },
      fieldErrors() { return this.errors[this.attribute] || {} },
      hasErrors() { return this.fieldErrors.length > 0 },
      errorString() {
        return _.map(this.fieldErrors, ({name}) => name) //TODO
      }
    },

    methods: {
      updateValue(value) {
        if (this.type === 'textarea') {
          if (value && value.length > 0)
            this.$el.querySelector('p.placeholder').style.display = 'none'
          else
            this.$el.querySelector('p.placeholder').style.display = 'inherit'
        }

        this.$refs.input.value = value
        this.$emit('input', value)
      }
    }
  }
</script>

<style scoped>
  div.field-error-group.inline {
    display: inline-block;
  }

  div.field-error-group {
    position: relative;
  }

  p.placeholder {
    position: absolute;
    top: 3px;
    left: 1px;
    color: rgb(169, 169, 169);
    padding: 5px;
    font-size: 16px;
    pointer-events: none;

    &.textarea-placeholder {
      white-space: pre;
    }
  }

  input, textarea {
    display: block;
    width: 100%;
    box-sizing: border-box;
  }

  textarea {
    width: 100%;
    max-width: 480px;
    height: calc(16px * 20);
  }
</style>
