"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _propertyHeader = _interopRequireDefault(require("./property-header"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * Prints `thead` section for table with records.
 *
 * @component
 * @example <caption>List with 2 properties</caption>
 * const properties = [{
 *   label: 'First Name',
 *   name: 'firstName',
 *   isSortable: true,
 * }, {
 *   label: 'Last Name',
 *   name: 'lastName',
 * }]
 * return (
 * <WrapperBox border>
 *   <Table>
 *    <RecordsTableHeader
 *      properties={properties}
 *      titleProperty={properties[0]}
 *      sortBy={'firstName'}
 *      direction={'asc'}
 *    />
 *    <tbody><tr>
 *      <td>John</td>
 *      <td>Doe</td>
 *      <td><StyledButton>Do something with John</StyledButton></td>
 *    </tr></tbody>
 *   </Table>
 * </WrapperBox>
 * )
 */
const RecordsTableHeader = props => {
  const {
    titleProperty,
    properties,
    sortBy,
    direction
  } = props;
  return _react.default.createElement("thead", null, _react.default.createElement("tr", {
    key: "header"
  }, properties.map(property => _react.default.createElement(_propertyHeader.default, {
    key: property.name,
    titleProperty: titleProperty,
    property: property,
    sortBy: sortBy,
    direction: direction
  })), _react.default.createElement("th", {
    key: "actions",
    style: {
      width: 80
    }
  })));
};

var _default = RecordsTableHeader;
exports.default = _default;