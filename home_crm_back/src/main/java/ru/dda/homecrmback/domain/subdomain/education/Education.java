package ru.dda.homecrmback.domain.subdomain.education;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;

import java.util.List;

public interface Education {
    interface Test {
        @Builder
        record Create(
                String name,
                Organization.FindById organization

        ) implements IExecute<Education.Test.Create> {

            public static Education.Test.Create of(String name) {
                return new Education.Test.Create(
                        name,
                        Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record FindById(
                long testId,
                long organizationId
        ) implements IExecute<Education.Test.FindById> {

            public static Education.Test.FindById of(long testId, long organizationId) {
                return new Education.Test.FindById(testId, organizationId);
            }
        }
    }

    interface Question {
        @Builder
        record Create(
                String text,
                Education.Test.FindById test,
                List<Education.Question.Create.Option> options

        ) implements IExecute<Education.Question.Create> {

            public static Education.Question.Create of(String text, long testId, List<Education.Question.Create.Option> options) {
                return new Education.Question.Create(
                        text,
                        Education.Test.FindById.of(testId, UserContextHolder.getCurrentUser().getOrganizationId()),
                        options);
            }

            @Builder
            public record Option(
                    String text,
                    boolean correct

            ) implements IExecute<Education.Test.Create> {

                public static Education.Test.Create of(String name) {
                    return new Education.Test.Create(
                            name,
                            Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
                }
            }
        }
    }

    interface Option {

    }
}
