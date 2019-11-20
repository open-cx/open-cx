"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var flat = _interopRequireWildcard(require("flat"));

var _viewHelpers = _interopRequireDefault(require("../../../../backend/utils/view-helpers"));

function _getRequireWildcardCache() { if (typeof WeakMap !== "function") return null; var cache = new WeakMap(); _getRequireWildcardCache = function () { return cache; }; return cache; }

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } var cache = _getRequireWildcardCache(); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; if (obj != null) { var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class List extends _react.default.PureComponent {
  render() {
    const {
      property,
      record,
      resource
    } = this.props;
    const showAction = record.recordActions.find(a => a.name === 'show');
    const unflatten = flat.unflatten(record.params);
    const values = unflatten[property.name] || [];

    if (resource.titleProperty.name === property.name && showAction) {
      const h = new _viewHelpers.default();
      const href = h.recordActionUrl({
        resourceId: resource.id,
        recordId: record.id,
        actionName: 'show'
      });
      return _react.default.createElement(_reactRouterDom.Link, {
        to: href
      }, `length: ${values.length}`);
    }

    return _react.default.createElement("span", null, `length: ${values.length}`);
  }

}

exports.default = List;