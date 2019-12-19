"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _viewHelpers = _interopRequireDefault(require("../../../../backend/utils/view-helpers"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

class List extends _react.default.PureComponent {
  render() {
    const {
      property,
      record,
      resource
    } = this.props;
    const showAction = record.recordActions.find(a => a.name === 'show');
    const original = record.params[property.name] || '';
    const value = original.substring(0, 15) + (original.length > 15 ? '...' : '');

    if (resource.titleProperty.name === property.name && showAction) {
      const h = new _viewHelpers.default();
      const href = h.recordActionUrl({
        resourceId: resource.id,
        recordId: record.id,
        actionName: 'show'
      });
      return _react.default.createElement(_reactRouterDom.Link, {
        to: href
      }, value);
    }

    return _react.default.createElement("span", null, value);
  }

}

exports.default = List;