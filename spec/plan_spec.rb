require 'spec_helper'

module PayuPayments
  describe Plan do

    it "should be able to create a plan" do
        plan = {
                plan: {
                      planCode: "sample-plan-code-001",
                      description: "Sample Plan 001",
                      accountId: "1",
                      intervalCount: "1",
                      interval: "MONTH",
                      maxPaymentsAllowed: "12",
                      maxPaymentAttempts: "3",
                      paymentAttemptsDelay: "1",
                      maxPendingPayments: "0",
                      trialDays: "30",
                      additionalValues: {
                              additionalValue: [{ name: "PLAN_VALUE",
                                                  value: "20000",
                                                  currency: "COP"
                                                },
                                                {
                                                  name: "PLAN_TAX",
                                                  value: "1600",
                                                  currency: "COP"
                                                }]
                      }
                }
        }
        my_plan = Plan.new(plan)
        my_plan.should_receive(:http_call).with("post", "/payments-api/rest/v4.3/plans", plan).and_return(plan)
        my_plan.save

    end
  end

end
