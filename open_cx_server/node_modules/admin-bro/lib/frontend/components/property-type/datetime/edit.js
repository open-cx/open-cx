"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInEdit = _interopRequireDefault(require("../../ui/property-in-edit"));

var _styledInput = _interopRequireDefault(require("../../ui/styled-input"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class Edit extends _react.default.Component {
  constructor(props) {
    super(props);
    this.datepickerRef = _react.default.createRef();
  }

  componentDidMount() {
    this.setupDatePicker();
  }

  shouldComponentUpdate(nextProps) {
    const {
      record,
      property
    } = this.props;
    const nextRecord = nextProps.record;
    const value = record.params && record.params[property.name] || '';
    const nextValue = nextRecord.params && nextRecord.params[property.name] || '';

    if (nextValue !== value) {
      if (nextValue) {
        this.datepickerRef.current._flatpickr.jumpToDate(nextValue);
      } else {
        this.datepickerRef.current._flatpickr.input.value = '';
      }
    }

    const prevError = record.errors && record.errors[property.name];
    const newError = nextRecord.errors && nextRecord.errors[property.name];
    return prevError !== newError;
  }

  setupDatePicker() {
    const {
      record,
      property
    } = this.props;
    const defaultDate = record.params && record.params[property.name] || null;
    let options = {
      format: 'Y-m-d',
      enableTime: false,
      // eslint-disable-next-line @typescript-eslint/camelcase
      time_24hr: false
    };

    if (property.type === 'datetime') {
      options = {
        format: 'Y-m-d H:i',
        enableTime: true,
        // eslint-disable-next-line @typescript-eslint/camelcase
        time_24hr: true
      };
    }

    const inst = flatpickr(this.datepickerRef.current, {
      defaultDate,
      ...options
    });
    inst.config.onChange.push((dates, text) => {
      this.handleChange(text);
    });
  }

  handleChange(value) {
    const {
      onChange,
      property
    } = this.props;
    onChange(property.name, new Date(value));
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
    }, _react.default.createElement("div", {
      className: "control has-icons-right"
    }, _react.default.createElement(_styledInput.default, {
      type: "text",
      className: "input pickadate",
      id: property.name,
      ref: this.datepickerRef,
      name: property.name
    }), _react.default.createElement("span", {
      className: "icon is-small is-right"
    }, _react.default.createElement("i", {
      className: "icomoon-calendar"
    }))));
  }

}

exports.default = Edit;