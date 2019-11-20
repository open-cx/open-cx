"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

/**
 * @implements Action
 * @category Actions
 * @module NewAction
 * @description
 * Shows form for creating a new record
 * Uses {@link NewAction} component to render form
 */
const NewAction = {
  name: 'new',
  isVisible: true,
  actionType: 'resource',
  icon: 'icomoon-add',
  label: 'Add new',

  /**
   * Responsible for creating new record.
   *
   * To invoke this action use {@link ApiClient#resourceAction}
   *
   * @implements Action.handler
   * @memberof module:NewAction
   * @return {Promise<NewActionResponse>} populated records
   */
  handler: async (request, response, data) => {
    if (request.method === 'post') {
      let record = await data.resource.build(request.payload ? request.payload.record : {});
      record = await record.save();

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
    } // TODO: add wrong implementation error


    throw new Error('new action can be invoked only via `post` http method');
  }
};
var _default = NewAction;
/**
 * Response returned by NewAction
 * @memberof module:NewAction
 * @alias NewActionResponse
 */

exports.default = _default;