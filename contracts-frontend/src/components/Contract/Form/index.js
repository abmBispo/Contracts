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
import { useHistory } from 'react-router-dom';

const key = 'updatable';

const openMessage = () => {
  message.loading({ content: 'Saving contract...', key });
  setTimeout(() => {
    message.success({ content: 'Contract has been saved successfully!', key, duration: 2 });
  }, 1000);
};

export default ({ removeTab, initialValues }) => {
  const [form] = Form.useForm();
  let history = useHistory();

  const onFinish = (values) => {
    const parsedValues = {
      title: values.title,
      begin: formatDate(new Date(values.begin)),
      end: formatDate(new Date(values.end)),
      file: new Blob([values.file.file], { type: 'text/pdf' }),
      filename: values.file.file.name
    }

    let data = new FormData();
    data.append('contract[title]', parsedValues.title);
    data.append('contract[begin]', parsedValues.begin);
    data.append('contract[end]', parsedValues.end);
    data.append('contract[file]', parsedValues.file, parsedValues.filename);

    axios.post(`${BASE_URL}/contracts`, data)
      .then((res) => {
        form.resetFields();
        removeTab('new-contract');
        openMessage();
      })
  }

  const requiredFields = [
    {
      required: true,
      message: "Can't be blank!",
    }
  ]

  const handleUpload = ({ onSuccess }) => {
    return new Promise(((resolve, _) => {
      setTimeout(() => resolve(onSuccess('done')), 500);
    }));
  };

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
        onFinish={onFinish}>

        <Form.Item rules={requiredFields} label="Contract title" name='title'>
          <Input />
        </Form.Item>

        <Form.Item rules={requiredFields} label="Begin date" name='begin'>
          <DatePicker />
        </Form.Item>

        <Form.Item rules={requiredFields} label="End date" name='end'>
          <DatePicker />
        </Form.Item>

        <Form.Item label="Dragger">
          <Form.Item name="file" rules={requiredFields} valuePropName="file" multiple={false}>
            <Upload.Dragger name="file" customRequest={handleUpload}>
              <p className="ant-upload-drag-icon">
                <InboxOutlined />
              </p>
              <p className="ant-upload-text">Click or drag file to this area to upload</p>
              <p className="ant-upload-hint">Support for a single upload.</p>
            </Upload.Dragger>
          </Form.Item>
        </Form.Item>

        <Form.Item wrapperCol={{ span: 24 }}>
          <div style={{ float: 'right' }}>
            <Button type='danger' onClick={() => history.push('/contracts')} style={{ marginRight: 10 }}>
              Back
            </Button>
            <Button type="primary" htmlType="submit">
              SAVE
            </Button>
          </div>
        </Form.Item>

      </Form>
    </>
  );
};
