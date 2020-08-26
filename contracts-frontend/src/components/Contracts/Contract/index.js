import React from 'react';
import moment from 'moment';
import { Descriptions, Badge } from 'antd';


const parsedInitialValues = (initialValues) => {
  return {
    title: initialValues.title,
    begin: moment(initialValues.begin, "DD-MM-YYYY"),
    end: moment(initialValues.end, "DD-MM-YYYY"),
  }
}

export default ({ title, begin, end, file }) => (
  <>
    <Descriptions title="Contract info" bordered>
      <Descriptions.Item label="Contract title">{title}</Descriptions.Item>
      <Descriptions.Item label="Begin date">{begin}</Descriptions.Item>
      <Descriptions.Item label="Begin date">{end}</Descriptions.Item>
    </Descriptions>
    <embed src={`http://localhost:4000/files/contracts/${file.file_name}`} width="100%" height="600"/>
  </>
)
