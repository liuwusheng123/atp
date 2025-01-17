package com.uusoft.atp.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.uusoft.atp.model.TestServiceInfo;

public interface TestServiceMapper {
	
	int insert(TestServiceInfo testServiceInfo);
	
	List<TestServiceInfo> selectAll();
	
	TestServiceInfo selectById(@Param("service_id") int service_id);
	
	int updateById(TestServiceInfo testServiceInfo);
	
	int deleteById(@Param("service_id") int service_id);
	
	int selectSeviceIdByName(@Param("service_name") String service_name);

	TestServiceInfo selectByMethodId(int method_id);
	
	List<String> selectUnCreateService();
	
	
}
