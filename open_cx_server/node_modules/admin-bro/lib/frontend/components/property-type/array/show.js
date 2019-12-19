"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyInShow = _interopRequireDefault(require("../../ui/property-in-show"));

var _convertParamsToArrayItems = _interopRequireDefault(require("./convert-params-to-array-items"));

var _styledSection = _interopRequireDefault(require("../../ui/styled-section"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

class Show extends _react.default.PureComponent {
  render() {
    const {
      property,
      record,
      ItemComponent
    } = this.props;
    const items = (0, _convertParamsToArrayItems.default)(property, record);
    return _react.default.createElement(_propertyInShow.default, {
      property: property
    }, _react.default.createElement(_styledSection.default, null, items.map((item, i) => _react.default.createElement(ItemComponent, _extends({}, this.props, {
      // eslint-disable-next-line react/no-array-index-key
      key: i,
      property: { ...property,
        name: `${property.name}.${i}`,
        label: `[${i + 1}]`,
        isArray: false
      }
    })))));
  }

}

exports.default = Show;