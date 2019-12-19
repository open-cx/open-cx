"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireDefault(require("react"));

var _recordInList = _interopRequireDefault(require("./record-in-list"));

var _recordsTableHeader = _interopRequireDefault(require("./records-table-header"));

var _noRecords = _interopRequireDefault(require("./no-records"));

var _table = _interopRequireDefault(require("../ui/table"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

const RecordsTable = props => {
  const {
    resource,
    records,
    actionPerformed,
    sortBy,
    direction,
    isLoading
  } = props;

  if (!records.length) {
    return _react.default.createElement(_noRecords.default, {
      resource: resource
    });
  }

  return _react.default.createElement(_table.default, null, _react.default.createElement(_recordsTableHeader.default, {
    properties: resource.listProperties,
    titleProperty: resource.titleProperty,
    direction: direction,
    sortBy: sortBy
  }), _react.default.createElement("tbody", null, records.map(record => _react.default.createElement(_recordInList.default, {
    record: record,
    resource: resource,
    key: record.id,
    actionPerformed: actionPerformed,
    isLoading: isLoading
  }))));
};

var _default = RecordsTable;
exports.default = _default;