package ai.maum.biz.fastaicc.common.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import ai.maum.biz.fastaicc.common.CustomProperties;


@Configuration
@MapperScan(basePackages={"ai.maum.biz.fastaicc.main.api.mapper", "ai.maum.biz.fastaicc.main.cousult.ailvr.mapper", "ai.maum.biz.fastaicc.main.cousult.autocall.mapper", "ai.maum.biz.fastaicc.main.cousult.callrecording.mapper", "ai.maum.biz.fastaicc.main.cousult.common.mapper", "ai.maum.biz.fastaicc.main.cousult.inbound.mapper", "ai.maum.biz.fastaicc.main.cousult.outbound.mapper", "ai.maum.biz.fastaicc.main.cousult.voc.mapper", "ai.maum.biz.fastaicc.main.cousult.voiceBot.mapper", "ai.maum.biz.fastaicc.main.statistic.mapper", "ai.maum.biz.fastaicc.main.system.admin.mapper", "ai.maum.biz.fastaicc.main.system.menu.mapper", "ai.maum.biz.fastaicc.main.user.mapper", "ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.mapper", "ai.maum.biz.fastaicc.main.workRequestProcess.mapper"}, sqlSessionFactoryRef="mainSqlSessionFactory")
@EnableTransactionManagement
public class MainDatabaseConfig {

	@Autowired
	CustomProperties customProperties;
	
	
	@Bean(name = "mainDataSource")
	@Primary
	@ConfigurationProperties(prefix = "spring.datasource1")
	public DataSource mainDataSource() {
		return DataSourceBuilder.create().build();
	}
	
	@Bean(name = "mainSqlSessionFactory")
	@Primary
	public SqlSessionFactory mainSqlSessionFactory(@Qualifier("mainDataSource") DataSource mainDataSource) throws Exception{
	    org.apache.ibatis.session.Configuration configuration = this.getMybatisConfig();

		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(mainDataSource);
		sqlSessionFactoryBean.setConfiguration(configuration);
		Resource[] res = new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/mapper/"+customProperties.getDatabaseActive()+"/main/**/*.xml");
		
		sqlSessionFactoryBean.setMapperLocations(res);
		
		return sqlSessionFactoryBean.getObject();
	}
	
	@Bean(name = "mainSqlSessionTemplate")
	@Primary
	public SqlSessionTemplate mainSqlSessionTemplate(SqlSessionFactory mainSqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(mainSqlSessionFactory);
	}
	
	private org.apache.ibatis.session.Configuration getMybatisConfig() {
        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
		
        configuration.setMapUnderscoreToCamelCase(true);
        return configuration;

	}
	
	
}
