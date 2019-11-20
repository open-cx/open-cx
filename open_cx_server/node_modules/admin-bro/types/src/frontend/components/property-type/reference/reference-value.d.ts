import React from 'react';
import PropertyJSON from '../../../../backend/decorators/property-json.interface';
import RecordJSON from '../../../../backend/decorators/record-json.interface';
interface Props {
    property: PropertyJSON;
    record: RecordJSON;
}
declare const ReferenceValue: React.FC<Props>;
export default ReferenceValue;
