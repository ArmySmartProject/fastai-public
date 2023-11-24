package ai.maum.biz.fastaicc.common.config;

import org.springframework.batch.core.launch.support.SimpleJobLauncher;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.repository.support.MapJobRepositoryFactoryBean;
import org.springframework.batch.support.transaction.ResourcelessTransactionManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

@Configuration
@EnableScheduling
public class BatchConfig {

    // 배치 트랜잭션 관리 bean
    @Bean
    public ResourcelessTransactionManager batchTransactionManager() {
        return new ResourcelessTransactionManager();
    }

    // Map 형태로 Job Repository 를 생성하는 bean
    @Bean
    public MapJobRepositoryFactoryBean mapJobRepositoryFactoryBean(
            ResourcelessTransactionManager txManager) throws Exception {

        MapJobRepositoryFactoryBean factory =
                new MapJobRepositoryFactoryBean(txManager);
        factory.afterPropertiesSet();

        return factory;
    }

    // Job Repository 를 통해 DB proxy 를 생성하는 bean
    @Bean
    public JobRepository batchJobRepository(
            MapJobRepositoryFactoryBean factory) throws Exception {

        return factory.getObject();
    }

    // Job Launcher 에 Job Repository 를 할당하는 bean
    @Bean
    public SimpleJobLauncher batchJobLauncher(JobRepository jobRepository) {
        SimpleJobLauncher launcher = new SimpleJobLauncher();

        launcher.setJobRepository(jobRepository);
        return launcher;
    }

}
