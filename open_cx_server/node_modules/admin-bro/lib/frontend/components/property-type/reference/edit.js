"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _Async = _interopRequireDefault(require("react-select/lib/Async"));

var _styledComponents = require("styled-components");

var _apiClient = _interopRequireDefault(require("../../../utils/api-client"));

var _propertyInEdit = _interopRequireDefault(require("../../ui/property-in-edit"));

var _selectStyles = _interopRequireDefault(require("../../../styles/select-styles"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Edit extends _react.default.Component {
  constructor(props) {
    super(props);
    this.selected = null;
    this.loadOptions = this.loadOptions.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(selected) {
    const {
      onChange,
      property
    } = this.props;

    if (selected) {
      this.selected = selected.record;
      onChange(property.name, selected.value, selected.record);
    } else {
      onChange(property.name, '');
    }
  }

  async loadOptions(inputValue) {
    const {
      property
    } = this.props;
    const api = new _apiClient.default();
    const records = await api.searchRecords({
      resourceId: property.reference,
      query: inputValue
    });
    return records.map(record => ({
      value: record.id,
      label: record.title,
      record
    }));
  }

  render() {
    const {
      property,
      record,
      theme
    } = this.props;
    const error = record.errors && record.errors[property.name];
    const reference = record.populated && record.populated[property.name];
    let selectedOption = reference && {
      value: reference.id,
      label: reference.title
    };
    const styles = (0, _selectStyles.default)(theme);

    if (this.selected) {
      selectedOption = {
        value: this.selected.id,
        label: this.selected.title
      };
    }

    return _react.default.createElement(_propertyInEdit.default, {
      property: property,
      error: error
    }, _react.default.createElement(_Async.default, {
      cacheOptions: true,
      value: selectedOption,
      styles: styles,
      defaultOptions: true,
      loadOptions: this.loadOptions,
      onChange: this.handleChange
    }));
  }

}

var _default = (0, _styledComponents.withTheme)(Edit);

exports.default = _default;