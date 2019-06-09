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
    <p v-if="type === 'textarea'" class="placeholder textarea-placeholder" ref="placeholder">{{placeholder}}</p>

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

<script lang="ts">
  import Vue from 'vue'
  import Component from 'vue-class-component'
  import {Prop} from 'vue-property-decorator'
  import * as _ from 'lodash'

  import {Error, Errors} from 'types'

  @Component
  export default class Field extends Vue {
    $refs!: {
      placeholder?: HTMLParagraphElement
      input: HTMLTextAreaElement | HTMLInputElement
    }

    @Prop({}) value: string | number | null
    @Prop({default(): Errors { return {} }}) errors: Errors
    @Prop({type: String, required: true}) type: string
    @Prop({type: String, required: false}) placeholder: string
    @Prop({type: String, required: true}) name: string
    @Prop({type: Boolean}) required: boolean
    @Prop({type: Number}) maxlength: number

    private get attribute(): string {
      let [match, object, first, rest] = this.name.match(
          /^(\w+)(?:\[(\w+)\]((?:\[\w+\])*))?$/)
      return first + rest
    }
    private get fieldErrors(): Error[] { return this.errors[this.attribute] || [] }
    get hasErrors(): boolean { return this.fieldErrors.length > 0 }
    get errorString(): string {
      return _.map(this.fieldErrors, error => error.name).join(", ") //TODO
    }

    updateValue(value?: string | number) {
      let stringValue = _.isNumber(value) ? value.toString() : value

      if (this.type === 'textarea') {
        if (stringValue && stringValue.length > 0)
          this.$refs.placeholder.style.display = 'none'
        else
          this.$refs.placeholder.style.display = 'inherit'
      }

      this.$refs.input.value = stringValue
      this.$emit('input', value)
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
