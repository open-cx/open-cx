"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInFilter = _interopRequireWildcard(require("../../ui/property-in-filter"));

var BackendFilter = _interopRequireWildcard(require("../../../../backend/utils/filter"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const {
  PARAM_SEPARATOR
} = BackendFilter;

class Filter extends _react.default.Component {
  constructor(props) {
    super(props);
    this.pickerRef = {
      from: _react.default.createRef(),
      to: _react.default.createRef()
    };
  }

  componentDidMount() {
    this.setupDatePicker('from');
    this.setupDatePicker('to');
  }

  shouldComponentUpdate(nextProps) {
    const {
      property
    } = this.props;
    const fromKey = `${property.name}${PARAM_SEPARATOR}from`;
    const toKey = `${property.name}${PARAM_SEPARATOR}to`;
    const nextFilter = nextProps.filter || {};

    if (nextFilter[fromKey]) {
      this.pickerRef.from.current._flatpickr.jumpToDate(nextFilter[fromKey]);
    } else {
      this.pickerRef.from.current._flatpickr.input.value = '';
    }

    if (nextFilter[toKey]) {
      this.pickerRef.to.current._flatpickr.jumpToDate(nextFilter[toKey]);
    } else {
      this.pickerRef.to.current._flatpickr.input.value = '';
    }

    return false;
  }

  setupDatePicker(key) {
    const {
      property,
      filter
    } = this.props;
    const fieldKey = `${property.name}.${key}`;
    const defaultDate = filter[fieldKey] && new Date(filter[fieldKey]) || '';
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

    const inst = flatpickr(this.pickerRef[key].current, {
      format: 'Y-m-d H:i',
      defaultDate,
      ...options
    });
    inst.config.onChange.push((dates, text) => {
      this.handleChange(key, new Date(text));
    });
  }

  handleChange(key, value) {
    const {
      onChange,
      property
    } = this.props;
    const date = value !== '' ? new Date(value).toISOString() : '';
    onChange(`${property.name}${PARAM_SEPARATOR}${key}`, date);
  }

  renderFilter(where) {
    const key = where.toLowerCase();
    const {
      property
    } = this.props;
    const filterKey = `filter-${property.name}`;
    return _react.default.createElement("div", null, _react.default.createElement(_propertyInFilter.Label, null, "-", where, ":"), _react.default.createElement("div", {
      className: "control has-icons-right"
    }, _react.default.createElement("input", {
      type: "text",
      ref: this.pickerRef[key],
      className: "input filter",
      name: `${filterKey}${PARAM_SEPARATOR}${key}`
    }), _react.default.createElement("span", {
      className: "icon is-small is-right"
    }, _react.default.createElement("i", {
      className: "icomoon-calendar"
    }))));
  }

  render() {
    const {
      property
    } = this.props;
    return _react.default.createElement(_propertyInFilter.default, {
      property: property
    }, _react.default.createElement("div", {
      className: "date-range"
    }, this.renderFilter('From'), this.renderFilter('To')));
  }

}

exports.default = Filter;