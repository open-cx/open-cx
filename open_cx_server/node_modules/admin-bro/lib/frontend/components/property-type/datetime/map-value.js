"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _default = value => {
  if (!value) {
    return '';
  }

  const date = new Date(value);
  return date.toLocaleString();
};

exports.default = _default;