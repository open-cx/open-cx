"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInShow = _interopRequireDefault(require("../../ui/property-in-show"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Show extends _react.default.PureComponent {
  render() {
    const {
      property,
      record
    } = this.props;
    const value = record.params[property.name];
    const className = property.availableValues ? 'tag' : '';
    return _react.default.createElement(_propertyInShow.default, {
      property: property
    }, _react.default.createElement("span", {
      className: className
    }, value));
  }

}

exports.default = Show;