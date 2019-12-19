"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

/**
 * Error which is thrown when user
 * doesn't have an access to a given resource/action.
 *
 * @category Errors
 */
class ForbiddenError extends Error {
  /**
   * @param   {object} context
   * @param   {string} context.actionName
   * @param   {string} context.resourceId
   */
  constructor({
    actionName,
    resourceId
  }) {
    const msg = `
    You cannot perform an action: "${actionName}" on a 
    resource: "${resourceId}"
    `;
    super(msg);
    this.message = msg;
    this.name = 'ForbiddenError';
  }

}

var _default = ForbiddenError;
exports.default = _default;