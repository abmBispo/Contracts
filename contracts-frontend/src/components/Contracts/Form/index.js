import React from 'react';
import { InboxOutlined } from '@ant-design/icons';
import axios from 'axios';
import { BASE_URL } from '../../../main/consts';
import {
  Form,
  Input,
  Button,
  DatePicker,
  Upload,
  message
} from 'antd';
import { formatDate } from '../../../utils/Date';
import fs from 'fs';

const key = 'updatable';

const openMessage = () => {
  message.loading({ content: 'Saving contract...', key });
  setTimeout(() => {
    message.success({ content: 'Contract has been saved successfully!', key, duration: 2 });
  }, 1000);
};

const validateMessages = {
  required: '${label} is required!'
};

const requiredFields = [
  {
    required: true
  }
]

const handleUpload = ({ onSuccess }) => {
  return new Promise(((resolve, _) => {
    setTimeout(() => resolve(onSuccess('done')), 500);
  }));
};

function convertToByteArray(input) {
  var sliceSize = 512;
  var bytes = [];

  for (var offset = 0; offset < input.length; offset += sliceSize) {
    var slice = input.slice(offset, offset + sliceSize);

    var byteNumbers = new Array(slice.length);

    for (var i = 0; i < slice.length; i++) {
      byteNumbers[i] = slice.charCodeAt(i);
    }

    const byteArray = new Uint8Array(byteNumbers);

    bytes.push(byteArray);
  }

  return bytes;
}

export default ({ removeTab, initialValues }) => {
  const [form] = Form.useForm();

  const onFinish = (values) => {
    const reader = new FileReader();

    const parsedValues = {
      title: values.title,
      begin: formatDate(new Date(values.begin)),
      end: formatDate(new Date(values.end)),
      file: new Blob([values.file.file.originFileObj], { type: 'application/pdf' }),
      // file: reader.readAsText(values.file.file.originFileObj),
      filename: values.file.file.name
    }

    let data = new FormData();
    data.append('contract[title]', parsedValues.title);
    data.append('contract[begin]', parsedValues.begin);
    data.append('contract[end]', parsedValues.end);
    data.append('contract[file]', parsedValues.file, parsedValues.filename);

    axios.post(`${BASE_URL}/contracts`, data)
      .then((_) => {
        form.resetFields();
        removeTab('new-contract');
        openMessage();
      })
  }

  return (
    <>
      <Form
        form={form}
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 10 }}
        layout="horizontal"
        name='contract'
        size='large'
        initialValues={initialValues}
        onFinish={onFinish}
        validateMessages={validateMessages}>

        <Form.Item rules={requiredFields} label="Contract title" name='title' required={false}>
          <Input />
        </Form.Item>

        <Form.Item rules={requiredFields} label="Begin date" name='begin' required={false}>
          <DatePicker />
        </Form.Item>

        <Form.Item rules={requiredFields} label="End date" name='end' required={false}>
          <DatePicker />
        </Form.Item>

        <Form.Item label="Contract file" name="file" rules={requiredFields} valuePropName="file" multiple={false} required={false}>
          <Upload.Dragger name="file" customRequest={handleUpload}>
            <p className="ant-upload-drag-icon">
              <InboxOutlined />
            </p>
            <p className="ant-upload-text">Click or drag file to this area to upload</p>
            <p className="ant-upload-hint">Support for a single upload.</p>
          </Upload.Dragger>
        </Form.Item>

        <Form.Item wrapperCol={{ span: 24 }}>
          <div style={{ float: 'right' }}>
            <Button type="primary" htmlType="submit">
              SAVE
            </Button>
          </div>
        </Form.Item>
      </Form>
    </>
  );
};
