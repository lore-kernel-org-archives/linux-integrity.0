Return-Path: <SRS0=07is=V3=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61857C0650F
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Jul 2019 06:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D7DF2064A
	for <linux-integrity@archiver.kernel.org>; Tue, 30 Jul 2019 06:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbfG3G02 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:26:28 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37084 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbfG3G02 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 02:26:28 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0690B72CCE7;
        Tue, 30 Jul 2019 09:26:26 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E369E4A4AE7;
        Tue, 30 Jul 2019 09:26:25 +0300 (MSK)
Date:   Tue, 30 Jul 2019 09:26:25 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: ima-evm-utils: git tagging for release
Message-ID: <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

It seems that you are released v1.2 of ima-evm-utils. (I did not receive
any announcement on linux-integrity.) I noticed that you are not using
annotated tags for release versions.

I suggest you use annotated tags (possible even signed) for release
versions. (You will need to delete existing v1.2 local tag if you are
going to retag it with annotated tag.)

man git-tag:

  "Annotated tags are meant for release while lightweight tags are meant
  for private or temporary object labels. For this reason, some git
  commands for naming objects (like git describe) will ignore
  lightweight tags by default."

Thanks,


