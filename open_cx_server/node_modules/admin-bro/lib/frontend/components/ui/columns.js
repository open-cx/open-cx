"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _styledComponents = _interopRequireDefault(require("styled-components"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const StyledColumns = _styledComponents.default.section.attrs({
  className: 'columns is-multiline'
}).withConfig({
  displayName: "columns__StyledColumns",
  componentId: "sc-1g5enwk-0"
})([""]);
/**
 * Columns wrapper for the grid in AdminBro. It uses [bulma](https://bulma.io/documentation/) grid.
 *
 * Example usage with {@link Column}
 * ```JavaScript
 * import { Column, Columns } from 'admin-bro'
 * //...
 * return (
 *   <columns>
 *      <column width={8}>
 *        Some content on the left
 *      </column>
 *      <column width={4}>
 *        Some content on the right
 *      </column>
 *   </columns>
 *  )
 * ```
 *
 * @see https://bulma.io/documentation/
 * @see Column
 *
 * @component
 * @example
 * return (
 *   <Columns>
 *      <Column width={8}>
 *        Some content on the left
 *      </Column>
 *      <Column width={4}>
 *        Some content on the right
 *      </Column>
 *   </Columns>
 * )
 */


const Columns = props => _react.default.createElement(StyledColumns, props);

var _default = Columns;
exports.default = _default;