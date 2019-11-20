"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

var _actionButton = _interopRequireDefault(require("./action-button"));

var _propertyType = _interopRequireDefault(require("../property-type"));

var _dropdown = _interopRequireDefault(require("../ui/dropdown"));

var _placeholder = _interopRequireDefault(require("../ui/placeholder"));

var _propertyJson = require("../../../backend/decorators/property-json.interface");

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const Td = _styledComponents.default.td.withConfig({
  displayName: "record-in-list__Td",
  componentId: "sc-145opzz-0"
})(["&&&{color:", ";& a:not(.in-dropdown){color:", ";}&.main{font-weight:bold;}}"], ({
  theme
}) => theme.colors.defaultText, ({
  theme
}) => theme.colors.primary);

class RecordInList extends _react.default.PureComponent {
  render() {
    const {
      resource,
      record,
      actionPerformed,
      isLoading
    } = this.props;
    const {
      recordActions
    } = record;
    return _react.default.createElement("tr", null, resource.listProperties.map(property => _react.default.createElement(Td, {
      key: property.name,
      className: resource.titleProperty.name === property.name ? 'main' : undefined
    }, isLoading ? _react.default.createElement(_placeholder.default, {
      style: {
        height: 14
      }
    }) : _react.default.createElement(_propertyType.default, {
      key: property.name,
      where: _propertyJson.PropertyPlace.list,
      property: property,
      resource: resource,
      record: record
    }))), _react.default.createElement(Td, {
      key: "options"
    }, recordActions.length ? _react.default.createElement(_dropdown.default, {
      className: "is-right is-hoverable"
    }, recordActions.map(action => _react.default.createElement(_actionButton.default, {
      action: action,
      key: action.name,
      resourceId: resource.id,
      recordId: record.id,
      actionPerformed: actionPerformed,
      className: "is-white in-dropdown"
    }))) : ''));
  }

}

exports.default = RecordInList;