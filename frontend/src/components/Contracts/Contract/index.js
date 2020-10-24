import React, { useEffect, useState } from 'react';
import { Descriptions, Row, Col, Divider, List, Button, Tooltip, Skeleton, message } from 'antd';
import { Typography } from 'antd';
import axios from 'axios';
import { BASE_URL } from '../../../main/consts';
import { DeleteOutlined, UserAddOutlined } from '@ant-design/icons'
import { Select } from 'antd';

const { Title } = Typography;
const { Option } = Select;

const key = 'updatable';

const successfullAddPart = () => message.success({
  content: 'Part has been added to contract!', key, duration: 3
});

const errorOnAddPart = (text) => message.error({ content: text, key, duration: 3 });

export default ({ id, title, begin, end, file }) => {
  const [parties, setParties] = useState([]);
  const [partiesOptions, setPartiesOptions] = useState([]);
  const [selectedPartOption, setSelectedPartOption] = useState(null);
  const [loading, setLoading] = useState(true);

  const removeRelation = (partId) => {
    setLoading(true);
    axios.delete(`${BASE_URL}/agreement/relation?part_id=${partId}&contract_id=${id}`)
  }

  const addRelation = () => {
    setLoading(true);
    axios.post(`${BASE_URL}/agreement/relation`, { relation: { part_id: selectedPartOption, contract_id: id } })
      .then(() => {
        setPartiesOptions([]);
        setSelectedPartOption(null);
        successfullAddPart();
      })
      .catch((err) => {
        errorOnAddPart(err.response.data.error);
      });
  }

  const searchPartiesOptions = (search) => {
    axios.get(`${BASE_URL}/parties?query_search=${search}`)
      .then((res) => {
        const { data } = res.data;
        setPartiesOptions(data);
      });
  }

  useEffect(() => {
    setTimeout(() => {
      if (loading) {
        axios.get(`${BASE_URL}/contracts/${id}/parties`)
          .then((res) => {
            const { data } = res.data;
            setParties(data);
            setLoading(false);
          });
      }
    }, 100)
  }, [loading]);

  return (
    <Row gutter={[16, 0]}>
      <Col span={12}>
        <Row gutter={[0, 20]}>
          <Col span={24}>
            <Title level={4}>General info</Title>
            <Descriptions title="" bordered>
              <Descriptions.Item label="Contract title">{title}</Descriptions.Item>
              <Descriptions.Item label="Begin date">{begin}</Descriptions.Item>
              <Descriptions.Item label="Begin date">{end}</Descriptions.Item>
            </Descriptions>
            <Divider />
            <Title level={4}>List of related parties</Title>

            {loading && <Skeleton active />}

            {!loading &&
              <List
                size="large"
                bordered
                dataSource={parties}
                renderItem={(item) =>
                  <List.Item key={item.id}>
                    {`${item.name} ${item.surname}`} - {item.email}
                    <div style={{ float: 'right' }}>
                      <Tooltip placement='left' title={`Remove user ${item.name} from this contract`}>
                        <Button type='danger' onClick={() => removeRelation(item.id)}>
                          <DeleteOutlined style={{ fontSize: 20 }} />
                        </Button>
                      </Tooltip>
                    </div>
                  </List.Item>
                }
              />
            }
          </Col>
        </Row>

        <Row>
          <Col span={24}>
            <Title level={4}>Add more parties to contract relation</Title>
          </Col>
        </Row>

        <Row gutter={[16, 0]}>
          <Col span={22}>
            <Select
              showSearch
              style={{ width: "100%" }}
              placeholder="Select a person (search by email or Tax ID)"
              filterOption={false}
              onSearch={searchPartiesOptions}
              onSelect={setSelectedPartOption}
              size='large'>
              {partiesOptions.map((part) => {
                return <Option key={part.id}>{part.name} - {part.email} - {part.tax_id}</Option>
              })}
            </Select>
          </Col>
          <Col span={2}>
            <Tooltip title="Add user to contract">
              <Button type='primary' size='large' disabled={!selectedPartOption} onClick={addRelation}>
                <UserAddOutlined style={{ fontSize: 20 }} />
              </Button>
            </Tooltip>
          </Col>
        </Row>

      </Col>
      <Col span={12}>
        <Title level={4}>Contract file</Title>
        <div style={{ marginTop: 20 }}>
          <embed src={`http://localhost:4000/files/contracts/${file.file_name}`} width="100%" height="600" />
        </div>
      </Col>
    </Row>
  )
};
