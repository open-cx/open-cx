"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _notFoundError = _interopRequireDefault(require("../utils/not-found-error"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * @implements Action
 * @category Actions
 * @module ShowAction
 * @description
 * Retruns selected Record
 * Uses {@link ShowAction} component to render form
 */
const ShowAction = {
  name: 'show',
  isVisible: true,
  actionType: 'record',
  icon: 'icomoon-info',
  label: 'Info',

  /**
   * Responsible for returning data for given record.
   *
   * To invoke this action use {@link ApiClient#recordAction}
   * @memberof module:ShowAction
   *
   * @return  {Promise<ShowActionResponse>}  populated record
   * @implements ActionHandler
   */
  handler: async (request, response, data) => {
    if (!data.record) {
      throw new _notFoundError.default([`Record of given id ("${request.params.recordId}") could not be found`].join('\n'), 'Action#handler');
    }

    return {
      record: data.record.toJSON(data.currentAdmin)
    };
  }
};
var _default = ShowAction;
/**
 * Response of a ShowAction
 * @memberof module:ShowAction
 * @alias ShowActionResponse
 */

exports.default = _default;