Return-Path: <SRS0=Ev+g=AS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496BC433DF
	for <linux-integrity@archiver.kernel.org>; Tue,  7 Jul 2020 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3695204EC
	for <linux-integrity@archiver.kernel.org>; Tue,  7 Jul 2020 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135845;
	bh=69SI/+M+EsrYPGUsjvNrScM3WRasXNkolneBXj8DZOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTO5J8C/zKroEUNJz9BfazAboprnptNM23KVJ2NG1uNSMJ5NnahlMQEGZ6KOs3Rnw
	 ksaVj8tkCsEVyL591G2NzAWjgVomiJEq4LS469B2YL/21Kq75gj9s0aQqgvj/KoCpK
	 rK2vEqPKJxg6VoTXitfERvr3wy6FXOzzdreYf/j8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgGGPap (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgGGPX6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 11:23:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251F52082F;
        Tue,  7 Jul 2020 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135437;
        bh=69SI/+M+EsrYPGUsjvNrScM3WRasXNkolneBXj8DZOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocPc7N5dSK6V6EHsGschyl3xU0LGyVbSaYwdf9+7mH0QyxQCiVIkHlZ7Fwz3hNOiw
         2ZxmQ9ugNKL7AeI/D5DwscGrNIDd9RYlF2EwVy613tm76YOlIXFVF+Xj1/xj6/5cE2
         07Mc0DDx6pJBP8VrREmIF736wRslSIjLYZ0XwrLE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 5.7 041/112] Revert "tpm: selftest: cleanup after unseal with wrong auth/policy test"
Date:   Tue,  7 Jul 2020 17:16:46 +0200
Message-Id: <20200707145802.953085875@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

commit 5be206eaac9a68992fc3b06fb5dd5634e323de86 upstream.

The reverted commit illegitly uses tpm2-tools. External dependencies are
absolutely forbidden from these tests. There is also the problem that
clearing is not necessarily wanted behavior if the test/target computer is
not used only solely for testing.

Fixes: a9920d3bad40 ("tpm: selftest: cleanup after unseal with wrong auth/policy test")
Cc: Tadeusz Struk <tadeusz.struk@intel.com>
Cc: stable@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/tpm2/test_smoke.sh |    5 -----
 1 file changed, 5 deletions(-)

--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -3,8 +3,3 @@
 
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
-
-CLEAR_CMD=$(which tpm2_clear)
-if [ -n $CLEAR_CMD ]; then
-	tpm2_clear -T device
-fi


