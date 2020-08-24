import React, { useState, useEffect } from 'react';
import { Table } from 'antd';
import axios from 'axios';
import { BASE_URL } from '../../../main/consts';

const columns = [
  {
    title: 'Name',
    dataIndex: 'name',
    sorter: (a, b) => a.title.length - b.title.length,
    sortDirections: ['descend', 'ascend'],
  },
  {
    title: 'Surname',
    dataIndex: 'surname',
    sorter: (a, b) => a.begin - b.begin,
    sortDirections: ['descend', 'ascend'],
  },
  {
    title: 'Tax ID',
    dataIndex: 'tax_id',
    sortDirections: ['descend', 'ascend'],
    sorter: (a, b) => a.end - b.end,
  },
  {
    title: 'Email',
    dataIndex: 'email',
    sortDirections: ['descend', 'ascend'],
    sorter: (a, b) => a.end - b.end,
  },
];

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
