import React from 'react';
import { NoticeMessageInState } from '../../store/store';
declare type NotifyProgress = (options: {
    noticeId: string;
    progress: number;
}) => void;
declare type NoticeBoxPropsFromState = {
    notices: Array<NoticeMessageInState>;
};
declare type NoticeBoxDispatchFromState = {
    drop: (noticeId: string) => void;
    notifyProgress: NotifyProgress;
};
declare const _default: import("react-redux").ConnectedComponent<React.FC<NoticeBoxPropsFromState & NoticeBoxDispatchFromState>, Pick<NoticeBoxPropsFromState & NoticeBoxDispatchFromState, never>>;
export default _default;
