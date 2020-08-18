import React, { useState } from 'react';
import {
  Form,
  Input,
  Button,
  DatePicker,
} from 'antd';

export default (props) => {
  const onFinish = (values) => {
    console.log(values);
  }

  const requiredFields = [
    {
      required: true,
      message: "Can't be blank!",
    }
  ]

  return (
    <>
      <Form
        labelCol={{ span: 4 }}
        wrapperCol={{ span: 10 }}
        layout="horizontal"
        name='contract'
        size={'large'}
        initialValues={props.values}
        onFinish={onFinish}>

        <Form.Item rules={requiredFields} label="Contract title" name='contract[title]'>
          <Input />
        </Form.Item>

        <Form.Item rules={requiredFields} label="Begin date" name='contract[begin]'>
          <DatePicker />
        </Form.Item>

        <Form.Item rules={requiredFields} label="End date" name='contract[end]'>
          <DatePicker />
        </Form.Item>

        <Form.Item wrapperCol={{ span: 24 }}>
          <Button type="primary" htmlType="submit" style={{ float: 'right' }}>
            SAVE
          </Button>
        </Form.Item>

      </Form>
    </>
  );
};
