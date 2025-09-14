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

        ) implements IExecute<Create> {

            public static Create of(String name) {
                return new Create(
                        name,
                        Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record Find(
                long testId,
                Organization.FindById organization
        ) implements IExecute<Find> {

            public static Find of(long testId) {
                return new Find(testId, Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record Update(
                Find test,
                String name,
                int timeLimitMinutes

        ) implements IExecute<Update> {

            public static Update of(long id, String name, int timeLimitMinutes) {
                return new Update(Find.of(id), name, timeLimitMinutes);
            }
        }

        @Builder
        record UpdateReady(
                Find test,
                boolean ready

        ) implements IExecute<UpdateReady> {

            public static UpdateReady of(long id, boolean ready) {
                return new UpdateReady(Find.of(id), ready);
            }
        }

        @Builder
        record Delete(
                Find test

        ) implements IExecute<Delete> {

            public static Delete of(long id) {
                return new Delete(Find.of(id));
            }
        }
    }

    interface Question {
        @Builder
        record Create(
                String text,
                Test.Find test,
                List<Education.Question.Create.Option> options

        ) implements IExecute<Education.Question.Create> {

            public static Education.Question.Create of(String text, long testId, List<Education.Question.Create.Option> options) {
                return new Education.Question.Create(
                        text,
                        Test.Find.of(testId),
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
