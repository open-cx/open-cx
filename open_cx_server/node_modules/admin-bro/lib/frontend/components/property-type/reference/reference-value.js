"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _viewHelpers = _interopRequireDefault(require("../../../../backend/utils/view-helpers"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const ReferenceValue = props => {
  const {
    property,
    record
  } = props;
  const h = new _viewHelpers.default();
  const refId = record.params[property.name];
  const populated = record.populated[property.name];
  const value = populated && populated.title || refId;

  if (!property.reference) {
    throw new Error(`property: "${property.name}" does not have a reference`);
  }

  if (populated && populated.recordActions.find(a => a.name === 'show')) {
    const href = h.recordActionUrl({
      resourceId: property.reference,
      recordId: refId,
      actionName: 'show'
    });
    return _react.default.createElement(_reactRouterDom.Link, {
      to: href
    }, value);
  }

  return _react.default.createElement("span", null, value);
};

var _default = ReferenceValue;
exports.default = _default;