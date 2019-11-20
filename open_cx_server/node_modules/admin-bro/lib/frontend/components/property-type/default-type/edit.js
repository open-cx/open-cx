"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactSelect = _interopRequireDefault(require("react-select"));

var _propertyInEdit = _interopRequireDefault(require("../../ui/property-in-edit"));

var _styledInput = _interopRequireDefault(require("../../ui/styled-input"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Edit extends _react.default.Component {
  constructor(props) {
    super(props);
    this.handleInputChange = this.handleInputChange.bind(this);
    this.handleSelectChange = this.handleSelectChange.bind(this);
  }

  handleInputChange(event) {
    const {
      onChange,
      property
    } = this.props;
    onChange(property.name, event.target.value);
  }

  handleSelectChange(selected) {
    const {
      onChange,
      property
    } = this.props;
    const value = selected ? selected.value : '';
    onChange(property.name, value);
  }

  renderInput() {
    const {
      property,
      record
    } = this.props;
    const value = record.params && typeof record.params[property.name] !== 'undefined' ? record.params[property.name] : '';

    if (property.availableValues) {
      const selected = property.availableValues.find(av => av.value === value);
      return _react.default.createElement(_reactSelect.default, {
        isClearable: true,
        value: selected,
        options: property.availableValues,
        onChange: this.handleSelectChange
      });
    }

    return _react.default.createElement(_styledInput.default, {
      type: "text",
      className: "input",
      id: property.name,
      name: property.name,
      onChange: this.handleInputChange,
      value: value
    });
  }

  render() {
    const {
      property,
      record
    } = this.props;
    const error = record.errors && record.errors[property.name];
    return _react.default.createElement(_propertyInEdit.default, {
      property: property,
      error: error
    }, this.renderInput());
  }

}

exports.default = Edit;