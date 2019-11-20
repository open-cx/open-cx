"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyType = _interopRequireDefault(require("../property-type"));

var _wrapperBox = _interopRequireDefault(require("../ui/wrapper-box"));

var _propertyJson = require("../../../backend/decorators/property-json.interface");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Show = props => {
  const {
    resource,
    record
  } = props;
  const properties = resource.showProperties;
  return _react.default.createElement(_wrapperBox.default, {
    border: true
  }, properties.map(property => _react.default.createElement(_propertyType.default, {
    key: property.name,
    where: _propertyJson.PropertyPlace.show,
    property: property,
    resource: resource,
    record: record
  })));
};

var _default = Show;
exports.default = _default;