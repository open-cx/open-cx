"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactSelect = _interopRequireDefault(require("react-select"));

var _styledComponents = require("styled-components");

var _propertyInFilter = _interopRequireDefault(require("../../ui/property-in-filter"));

var _selectStyles = require("../../../styles/select-styles");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Filter extends _react.default.PureComponent {
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
      filter,
      theme
    } = this.props;
    const filterKey = `filter-${property.name}`;
    const value = filter[property.name] || '';

    if (property.availableValues) {
      const selected = property.availableValues.find(av => av.value === value);
      return _react.default.createElement(_reactSelect.default, {
        value: typeof selected === 'undefined' ? '' : selected,
        isClearable: true,
        options: property.availableValues,
        styles: (0, _selectStyles.filterStyles)(theme),
        onChange: this.handleSelectChange
      });
    }

    return _react.default.createElement(_react.default.Fragment, null, _react.default.createElement("span", {
      className: "icon is-small is-right"
    }, _react.default.createElement("i", {
      className: "fas fa-search"
    })), _react.default.createElement("input", {
      type: "text",
      className: "input filter",
      name: filterKey,
      onChange: this.handleInputChange,
      value: value
    }));
  }

  render() {
    const {
      property
    } = this.props;
    return _react.default.createElement(_propertyInFilter.default, {
      property: property
    }, _react.default.createElement("div", {
      className: "control has-icons-left"
    }, this.renderInput()));
  }

}

var _default = (0, _styledComponents.withTheme)(Filter);

exports.default = _default;