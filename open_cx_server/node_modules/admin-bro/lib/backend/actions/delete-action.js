"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _notFoundError = _interopRequireDefault(require("../utils/not-found-error"));

var _validationError = _interopRequireDefault(require("../utils/validation-error"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

/**
 * @implements Action
 * @category Actions
 * @module DeleteAction
 * @description
 * Removes given record from the database. Since it doesn't have a
 * component - it redirects right away after clicking its {@link ActionButton}
 */
const DeleteAction = {
  name: 'delete',
  isVisible: true,
  actionType: 'record',
  icon: 'icomoon-remove-2',
  label: 'Remove',
  guard: 'Do you really want to remove this item?',
  component: false,

  /**
   * Responsible for deleting existing record.
   *
   * To invoke this action use {@link ApiClient#recordAction}
   *
   * @return  {Promise<RecordActionResponse>}
   * @implements ActionHandler
   * @memberof module:DeleteAction
   */
  handler: async (request, response, data) => {
    if (!request.params.recordId || !data.record) {
      throw new _notFoundError.default(['You have to pass "recordId" to Delete Action'].join('\n'), 'Action#handler');
    }

    try {
      await data.resource.delete(request.params.recordId);
    } catch (error) {
      if (error instanceof _validationError.default && error.baseError) {
        return {
          record: data.record.toJSON(data.currentAdmin),
          notice: {
            message: error.baseError.message,
            type: 'error'
          }
        };
      }

      throw error;
    }

    return {
      record: data.record.toJSON(data.currentAdmin),
      redirectUrl: data.h.resourceActionUrl({
        resourceId: data.resource.id(),
        actionName: 'list'
      }),
      notice: {
        message: 'Successfully removed given record',
        type: 'success'
      }
    };
  }
};
var _default = DeleteAction;
exports.default = _default;