package ru.dda.homecrmback.domain.subdomain.education;

import lombok.Builder;
import ru.dda.homecrmback.domain.IExecute;
import ru.dda.homecrmback.domain.subdomain.organization.Organization;
import ru.dda.homecrmback.domain.subdomain.user.context.UserContextHolder;

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
        record Find(
                long id,
                Test.Find test,
                Organization.FindById organization
        ) implements IExecute<Find> {

            public static Find of(long id, long testId) {
                return new Find(id,
                        Test.Find.of(testId),
                        Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record Create(
                String text,
                Test.Find test,
                Organization.FindById organization

        ) implements IExecute<Education.Question.Create> {

            public static Education.Question.Create of(String text, long testId) {
                return new Education.Question.Create(
                        text,
                        Test.Find.of(testId),
                        Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record Update(
                Find question,
                String text

        ) implements IExecute<Update> {

            public static Update of(long id, String text, long testId) {
                return new Update(
                        Find.of(id, testId),
                        text);
            }
        }

        @Builder
        record Delete(
                Find question

        ) implements IExecute<Delete> {

            public static Delete of(long id, long testId) {
                return new Delete(Find.of(id, testId));
            }
        }
    }

    interface Option {
        @Builder
        record Find(
                long id,
                Question.Find question,
                Organization.FindById organization

        ) implements IExecute<Find> {

            public static Find of(long id, long questionId, long testId) {
                return new Find(
                        id,
                        Question.Find.of(questionId, testId),
                        Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record Create(
                String text,
                boolean correct,
                Question.Find question,
                Organization.FindById organization

        ) implements IExecute<Create> {

            public static Create of(String text, boolean correct, long questionId, long testId) {
                return new Create(
                        text,
                        correct,
                        Question.Find.of(questionId, testId),
                        Organization.FindById.of(UserContextHolder.getCurrentUser().getOrganizationId()));
            }
        }

        @Builder
        record Update(
                Find option,
                String text,
                boolean correct

        ) implements IExecute<Update> {

            public static Update of(long id, String text, boolean correct, long questionId, long testId) {
                return new Update(Find.of(id, questionId, testId), text, correct);
            }
        }

        @Builder
        record Delete(
                Find option

        ) implements IExecute<Delete> {

            public static Delete of(long id, long questionId, long testId) {
                return new Delete(Find.of(id, questionId, testId));
            }
        }
    }
}
