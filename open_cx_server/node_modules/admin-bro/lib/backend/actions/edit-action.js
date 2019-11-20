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
 * @module EditAction
 * @description
 * Shows form for updating existing record
 *
 * Uses {@link EditAction} component to render form
 */
const EditAction = {
  name: 'edit',
  isVisible: true,
  actionType: 'record',
  icon: 'icomoon-edit',
  label: 'Edit',

  /**
   * Responsible for updating existing record.
   *
   * To invoke this action use {@link ApiClient#recordAction}
   *
   * @return  {EditActionResponse}  populated record
   * @implements Action.handler
   * @memberof module:EditAction
   */
  handler: async (request, response, data) => {
    const {
      record
    } = data;

    if (!record) {
      throw new _notFoundError.default([`Record of given id ("${request.params.recordId}") could not be found`].join('\n'), 'Action#handler');
    }

    if (request.method === 'get') {
      return {
        record: record.toJSON(data.currentAdmin)
      };
    }

    await record.update(request.payload && request.payload.record);

    if (record.isValid()) {
      return {
        redirectUrl: data.h.recordActionUrl({
          resourceId: data.resource.id(),
          recordId: record.id(),
          actionName: 'show'
        }),
        record: record.toJSON(data.currentAdmin)
      };
    }

    return {
      record: record.toJSON(data.currentAdmin)
    };
  }
};
var _default = EditAction;
/**
 * Type of response returned by {@link module:DeleteAction}
 * @memberof module:EditAction
 */

exports.default = _default;