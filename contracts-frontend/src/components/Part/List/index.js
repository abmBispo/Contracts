import React, { useState, useEffect } from 'react';
import { Table, Button, Tooltip } from 'antd';
import axios from 'axios';
import { BASE_URL } from '../../../main/consts';
import { useHistory } from 'react-router-dom';
import { EditOutlined } from '@ant-design/icons'

const mapApiToProps = params => {
  return {
    page: params.pagination.current,
    ...params,
  };
};

export default (props) => {
  const [loading, setLoading] = useState(false);
  const [pagination, setPagination] = useState({ current: 1, pageSize: 25 });
  const [data, setData] = useState([]);
  let history = useHistory();

  const handleEditClick = (userId) => {
    history.push(`/parties/${userId}/update`);
  }

  const columns = [
    {
      title: 'Name',
      dataIndex: 'name',
      sorter: (a, b) => a.name.length - b.name.length,
      sortDirections: ['descend', 'ascend'],
    },
    {
      title: 'Surname',
      dataIndex: 'surname',
      sorter: (a, b) => a.surname - b.surname,
      sortDirections: ['descend', 'ascend'],
    },
    {
      title: 'Tax ID',
      dataIndex: 'tax_id',
      sortDirections: ['descend', 'ascend'],
      sorter: (a, b) => a.tax_id - b.tax_id,
    },
    {
      title: 'Email',
      dataIndex: 'email',
      sortDirections: ['descend', 'ascend'],
      sorter: (a, b) => a.email - b.email,
    },
    {
      title: 'Actions',
      render: (text, record) => (
        <Tooltip title={`Edit user ${record.name}`}>
          <Button onClick={() => handleEditClick(record.id)} type='primary'>
            <EditOutlined style={{ fontSize: 20 }} />
          </Button>
        </Tooltip>
      )
    },
  ];

  useEffect(() => fetch(), [props.activeKey]);

  const fetch = (params = {}) => {
    setLoading(true);
    axios
      .get(`${BASE_URL}/parties?page=${pagination.current}`)
      .then((res) => {
        const { data } = mapApiToProps(res.data);
        setLoading(false);
        setData(data);
        setPagination({
          ...pagination,
          ...res.data.pagination
        });
      });
  }

  const handleTableChange = (pagination, filters, sorter) => {
    fetch({
      sortField: sorter.field,
      sortOrder: sorter.order,
      pagination
    });
  }

  return (
    <Table
      columns={columns}
      rowKey={(record) => record.id}
      dataSource={data}
      pagination={pagination}
      loading={loading}
      onChange={handleTableChange}
    />
  );
}
