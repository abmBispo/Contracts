import React, { useEffect, useState } from 'react';
import axios from 'axios';
import MaskedInput from 'antd-mask-input';
import { BASE_URL } from '../../../main/consts';
import { useHistory } from 'react-router-dom';
import {
  Form,
  Input,
  Button,
  Breadcrumb,
  message
} from 'antd';

const key = 'updatable';

const openMessage = (content = '') => {
  message.loading({ content: 'Saving part...', key });
  setTimeout(() => {
    message.success({ content: content, key, duration: 2 });
  }, 1000);
};

const parseValues = (values) => {
  return {
    part: {
      name: values.name,
      surname: values.surname,
      email: values.email,
      tax_id: values.tax_id,
      telephone: values.telephone,
    }
  }
}

export default ({ match }) => {
  const [form] = Form.useForm();
  let history = useHistory();

  const { partId } = match.params;

  const [initialValues, setInitialValues] = useState({});

  useEffect(() => {
    axios.get(`${BASE_URL}/parties/${partId}`)
    .then((res) => {
      const { data } = res.data;
      form.setFieldsValue(data);
      setInitialValues(data);
    });
  }, []);

  console.log(initialValues);

  const create = (values) => {
    const parsedValues = parseValues(values);
    axios.post(`${BASE_URL}/parties`, parsedValues).then(() => {
      form.resetFields();
      openMessage('Part has been created successfully!');
      history.push('/parties');
    })
  }

  const update = (values) => {
    const parsedValues = parseValues(values);
    axios.put(`${BASE_URL}/parties/${partId}`, parsedValues).then(() => {
      form.resetFields();
      openMessage('Part has been updated successfully!');
      history.push('/parties');
    })
  }

  const requiredFields = [{ required: true }]
  const validateMessages = {
    required: '${label} is required!',
    types: {
      email: '${label} is invalid!',
    }
  };

  return (
    <>
      <Breadcrumb style={{ margin: '16px 0' }}>
        <Breadcrumb.Item>App</Breadcrumb.Item>
        <Breadcrumb.Item href='/#/parties'>Parties</Breadcrumb.Item>
        <Breadcrumb.Item>{initialValues ? `${initialValues.name} ${initialValues.surname}` : 'New Part'}</Breadcrumb.Item>
      </Breadcrumb>
      <div className="site-layout-content">

        <Form
          form={form}
          labelCol={{ span: 4 }}
          wrapperCol={{ span: 10 }}
          layout="horizontal"
          name='contract'
          size='large'
          initialValues={initialValues}
          onFinish={initialValues ? update : create}
          validateMessages={validateMessages}>
            {}
          <Form.Item rules={requiredFields} label="Name" name='name' required={false}>
            <Input />
          </Form.Item>

          <Form.Item rules={requiredFields} label="Surname" name='surname' required={false}>
            <Input />
          </Form.Item>

          <Form.Item rules={[{ required: true, type: 'email' }]} label="E-mail" name='email' required={false}>
            <Input />
          </Form.Item>

          <Form.Item rules={requiredFields} label="Tax ID" name='tax_id' required={false}>
            <Input />
          </Form.Item>

          <Form.Item rules={requiredFields} label="Telephone" name='telephone' required={false}>
            <MaskedInput mask="+11 (11) 1 1111-1111" name="telephone" />
          </Form.Item>

          <Form.Item wrapperCol={{ span: 24 }}>
            <Button type="primary" htmlType="submit" style={{ float: 'right' }}>
            {initialValues ? "Update" : "Save"}
            </Button>
          </Form.Item>

        </Form>

      </div>
    </>
  );
};
