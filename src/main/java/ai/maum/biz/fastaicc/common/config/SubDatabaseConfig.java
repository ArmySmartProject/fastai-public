package ai.maum.biz.fastaicc.common.config;


import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;


@Configuration
@MapperScan(basePackages= {"ai.maum.biz.fastaicc.main.statistic.chatMapper", "ai.maum.biz.fastaicc.main.system.admin.botMapper",
		"ai.maum.biz.fastaicc.main.cousult.chatbotBuilder.chatbotMapper"}, sqlSessionFactoryRef="subSqlSessionFactory")
@EnableTransactionManagement
public class SubDatabaseConfig {

	@Bean(name = "subDataSource")
	@ConfigurationProperties(prefix = "spring.datasource2")
	public DataSource subDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean(name = "subSqlSessionFactory")
	public SqlSessionFactory subSqlSessionFactory(@Qualifier("subDataSource") DataSource subDataSource) throws Exception{
		org.apache.ibatis.session.Configuration configuration = this.getMybatisConfig();

		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(subDataSource);
		sqlSessionFactoryBean.setConfiguration(configuration);
		Resource[] res = new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/mapper/mysql/main/**/*.xml");
		sqlSessionFactoryBean.setMapperLocations(res);

		return sqlSessionFactoryBean.getObject();
	}

	@Bean(name = "subSqlSessionTemplate")
	public SqlSessionTemplate subSqlSessionTemplate(SqlSessionFactory subSqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(subSqlSessionFactory);
	}

//	@Bean(name = "subDataSourceTransactionManager")
//	public DataSourceTransactionManager transactionManager(@Qualifier("subDataSource") DataSource subDataSource) throws Exception {
//		return new DataSourceTransactionManager(subDataSource);
//	}

	private org.apache.ibatis.session.Configuration getMybatisConfig() {
        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();

        configuration.setMapUnderscoreToCamelCase(true);
        return configuration;

	}

}
