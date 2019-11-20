"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactSelect = _interopRequireDefault(require("react-select"));

var _styledComponents = require("styled-components");

var _mapValue = _interopRequireDefault(require("./map-value"));

var _propertyInFilter = _interopRequireDefault(require("../../ui/property-in-filter"));

var _selectStyles = require("../../../styles/select-styles");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Filter extends _react.default.PureComponent {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(selected) {
    const {
      onChange,
      property
    } = this.props;
    const value = selected ? selected.value : '';
    onChange(property.name, value);
  }

  render() {
    const {
      property,
      filter = {},
      theme
    } = this.props;
    const value = typeof filter[property.name] === 'undefined' ? '' : filter[property.name];
    const options = [{
      value: true,
      label: (0, _mapValue.default)(true)
    }, {
      value: false,
      label: (0, _mapValue.default)(false)
    }];
    const selected = options.find(o => o.value === value);
    return _react.default.createElement(_propertyInFilter.default, {
      property: property
    }, _react.default.createElement(_reactSelect.default, {
      value: typeof selected === 'undefined' ? '' : selected,
      isClearable: true,
      options: options,
      styles: (0, _selectStyles.filterStyles)(theme),
      onChange: this.handleChange
    }));
  }

}

var _default = (0, _styledComponents.withTheme)(Filter);

exports.default = _default;