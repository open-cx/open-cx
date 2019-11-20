"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
Object.defineProperty(exports, "delete", {
  enumerable: true,
  get: function () {
    return _deleteAction.default;
  }
});
Object.defineProperty(exports, "show", {
  enumerable: true,
  get: function () {
    return _showAction.default;
  }
});
Object.defineProperty(exports, "edit", {
  enumerable: true,
  get: function () {
    return _editAction.default;
  }
});
Object.defineProperty(exports, "new", {
  enumerable: true,
  get: function () {
    return _newAction.default;
  }
});
Object.defineProperty(exports, "list", {
  enumerable: true,
  get: function () {
    return _listAction.default;
  }
});

var _deleteAction = _interopRequireDefault(require("./delete-action"));

var _showAction = _interopRequireDefault(require("./show-action"));

var _editAction = _interopRequireDefault(require("./edit-action"));

var _newAction = _interopRequireDefault(require("./new-action"));

var _listAction = _interopRequireDefault(require("./list-action"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }