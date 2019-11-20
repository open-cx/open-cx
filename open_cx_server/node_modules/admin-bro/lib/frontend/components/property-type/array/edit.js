"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var flat = _interopRequireWildcard(require("flat"));

var _propertyInEdit = _interopRequireDefault(require("../../ui/property-in-edit"));

var _column = _interopRequireDefault(require("../../ui/column"));

var _columns = _interopRequireDefault(require("../../ui/columns"));

var _convertParamsToArrayItems = _interopRequireDefault(require("./convert-params-to-array-items"));

var _styledSection = _interopRequireDefault(require("../../ui/styled-section"));

var _ui = require("../../ui");

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

class Edit extends _react.default.Component {
  constructor(props) {
    super(props);
    const {
      property,
      record
    } = this.props;
    const items = (0, _convertParamsToArrayItems.default)(property, record);
    this.state = {
      items
    };
    this.addNew = this.addNew.bind(this);
  }

  addNew(event) {
    this.setState(state => ({ ...state,
      items: [...state.items, '']
    }));
    event.preventDefault();
    return false;
  }

  removeItem(i, event) {
    const {
      property,
      record,
      onChange
    } = this.props;
    const {
      items
    } = this.state;
    const newItems = [...items];
    newItems.splice(i, 1);
    const newRecord = { ...record
    };
    newRecord.params = flat.flatten({ ...flat.unflatten(newRecord.params),
      [property.name]: newItems
    });
    this.setState(state => ({ ...state,
      items: newItems
    }));
    onChange(newRecord);
    event.preventDefault();
    return false;
  }

  renderItem(item, i) {
    const {
      ItemComponent,
      property
    } = this.props;
    return _react.default.createElement(_columns.default, {
      key: i
    }, _react.default.createElement(_column.default, {
      width: 10
    }, _react.default.createElement(ItemComponent, _extends({}, this.props, {
      property: { ...property,
        name: `${property.name}.${i}`,
        label: `[${i + 1}]`,
        isArray: false
      }
    }))), _react.default.createElement(_column.default, {
      width: 2
    }, _react.default.createElement(_ui.StyledButton, {
      style: {
        marginTop: 25
      },
      onClick: event => this.removeItem(i, event)
    }, "Remove")));
  }

  renderInput() {
    const {
      items
    } = this.state;
    return _react.default.createElement(_styledSection.default, {
      style: {
        marginTop: 20
      }
    }, items.map((item, i) => this.renderItem(item, i)), _react.default.createElement("p", null, _react.default.createElement(_ui.StyledButton, {
      onClick: this.addNew
    }, "Add new item")));
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