import _ from 'lodash'
import bigInt from 'big-integer'

export default {
  encode(results) {
    let resultsStr = _.map(results, r => r.toString()).join('')
    let resultsNum = bigInt(resultsStr, 4)
    return resultsNum.toString(36)
  },

  decode(param) {
    let resultsNum = bigInt(param, 36)
    let resultsStr = resultsNum.toString(4)
    let resultsArray = resultsStr.split('')
    return _.map(resultsArray, r => Number.parseInt(r))
  }
}
