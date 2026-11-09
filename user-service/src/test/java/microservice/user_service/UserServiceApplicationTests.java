package microservice.user_service;

import io.github.alexisTrejo11.drugstore.users.UserServiceApplication;
import io.github.alexisTrejo11.drugstore.users.config.log.AuditLogger;
import io.github.alexisTrejo11.drugstore.users.config.security.ApiSecurityResponseWriter;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

@SpringBootTest(
    classes = UserServiceApplication.class,
    properties = "app.rate-limit.global.enabled=false"
)
@ActiveProfiles("test")
class UserServiceApplicationTests {

    @MockitoBean
    private AuditLogger auditLogger;

    @MockitoBean
    private ApiSecurityResponseWriter apiSecurityResponseWriter;

	@Test
	void contextLoads() {
	}

}
