"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _reactRouterDom = require("react-router-dom");

var _viewHelpers = _interopRequireDefault(require("../../../../backend/utils/view-helpers"));

var _label = _interopRequireDefault(require("../../ui/label"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

// TODO define ItemComponent interface
class List extends _react.default.PureComponent {
  renderItems() {
    const {
      property,
      ItemComponent
    } = this.props;
    return _react.default.createElement(_react.default.Fragment, null, property.subProperties.map(subProperty => _react.default.createElement("div", null, _react.default.createElement(_label.default, {
      style: {
        display: 'inline'
      }
    }, `${subProperty.label}: `), _react.default.createElement(ItemComponent, _extends({}, this.props, {
      key: subProperty.name,
      property: { ...subProperty,
        name: `${property.name}.${subProperty.name}`
      }
    })))));
  }

  render() {
    const {
      property,
      record,
      resource
    } = this.props;
    const showAction = record.recordActions.find(a => a.name === 'show');

    if (resource.titleProperty.name === property.name && showAction) {
      const h = new _viewHelpers.default();
      const href = h.recordActionUrl({
        resourceId: resource.id,
        recordId: record.id,
        actionName: 'show'
      });
      return _react.default.createElement(_reactRouterDom.Link, {
        to: href
      }, this.renderItems());
    }

    return this.renderItems();
  }

}

exports.default = List;