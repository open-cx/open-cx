"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

class ValidationError extends Error {
  /**
   * @param  {String} message   custom message
   * @param  {Object} errors    error messages
   * @param  {String} errors.{...}    error for particular field where ... is a
   *                                  {@link BaseProperty#path}
   * @param  {String} errors.{...}.message   human readible message
   * @param  {String} errors.{...}.type      string type (i.e. required)
   */
  constructor(message, errors) {
    super(message);
    this.errors = errors;
    this.message = message || 'Resource cannot be stored because of validation errors';
    this.name = 'ValidationError';
  }

}

var _default = ValidationError;
exports.default = _default;