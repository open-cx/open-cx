"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInEdit = _interopRequireDefault(require("../../ui/property-in-edit"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Edit extends _react.default.PureComponent {
  handleChange(event) {
    const {
      property,
      onChange
    } = this.props;
    const {
      checked
    } = event.target;
    onChange(property.name, checked);
  }

  render() {
    const {
      property,
      record
    } = this.props;
    const value = record.params && record.params[property.name] || '';
    const error = record.errors && record.errors[property.name];
    return _react.default.createElement(_propertyInEdit.default, {
      property: property,
      error: error
    }, _react.default.createElement("input", {
      type: "checkbox",
      className: "checkbox",
      id: property.name,
      name: property.name,
      onChange: this.handleChange.bind(this),
      checked: value
    }));
  }

}

exports.default = Edit;