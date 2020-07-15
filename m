Return-Path: <SRS0=nr5y=A2=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA23CC433E0
	for <linux-integrity@archiver.kernel.org>; Wed, 15 Jul 2020 21:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9744206F4
	for <linux-integrity@archiver.kernel.org>; Wed, 15 Jul 2020 21:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUhZup1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGOVjR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:39:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726479AbgGOVjR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 17:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594849156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EM6yxRSPKU4x0QOObOuZNirW5SXQQqWbMpXS9w5Yb4k=;
        b=ZUhZup1Lxp8PDO83353fn2+ON0EfI2E9aGsM2QGLuD7dIfiBT+knnP6Jy3JlM/hr3qdk0H
        e2RjPVbODnU7ZGEZABfePJs9N2aNi1rgdIduLSScFMAj1NhLXRHiJPZMfliIZOAI6cP2zU
        /YIgEDPmr0fg/JvsLFEpquAyWNyNq/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-9yMkxd9HMnKupUE22sNJ_Q-1; Wed, 15 Jul 2020 17:39:13 -0400
X-MC-Unique: 9yMkxd9HMnKupUE22sNJ_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DE038015FB;
        Wed, 15 Jul 2020 21:39:12 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32D9910013C2;
        Wed, 15 Jul 2020 21:39:09 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 0/3] ima-evm-utils: miscellanous bug fixes
Date:   Wed, 15 Jul 2020 18:39:03 -0300
Message-Id: <20200715213906.194041-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

While testing in RHEL7 the latest 'next-testing' branch changes the build
failed due to an "out" label being placed at the end of the function
calc_bootaggr() with no instructions for systems with OpenSSL version less
then 1.1. Corrected it by putting a simple no-op 'return' there (the
function returns nothing).

The other bugs are a simple memory leak, also on calc_bootaggr(), when
_DigestUpdate() returns error; and an overflow while reading the
boot_aggregate buffer due to the lack of the null char at the end.

Bruno Meneguele (3):
  ima-evm-utils: fix empty label at end of function.
  ima-evm-utils: fix memory leak in case of error
  ima-evm-utils: fix overflow on printing boot_aggregate

 src/evmctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.26.2

