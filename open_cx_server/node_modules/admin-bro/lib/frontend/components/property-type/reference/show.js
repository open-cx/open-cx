"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInShow = _interopRequireDefault(require("../../ui/property-in-show"));

var _referenceValue = _interopRequireDefault(require("./reference-value"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Show extends _react.default.PureComponent {
  render() {
    const {
      property,
      record
    } = this.props;
    return _react.default.createElement(_propertyInShow.default, {
      property: property
    }, _react.default.createElement(_referenceValue.default, {
      property: property,
      record: record
    }));
  }

}

exports.default = Show;