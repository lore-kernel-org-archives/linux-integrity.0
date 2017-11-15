Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:44157 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932305AbdKONlT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 08:41:19 -0500
From: Roberto Sassu <roberto.sassu@huawei.com>
To: <linux-integrity@vger.kernel.org>
CC: <linux-security-module@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [USER SPACE][RFC][PATCH 0/5] ima: digest-list-tools package
Date: Wed, 15 Nov 2017 14:39:21 +0100
Message-ID: <20171115133926.20108-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Recently, I published a patch set with title 'ima: digest list feature',
which allows users to upload to IMA a set of digests, that will be used as
reference values for measurement, appraisal and audit.

Although this patch set does not contain kernel patches, I would like to
publish it in the kernel mailing lists, so that people can have a better
understanding on how the digest list feature works, and can try it. The
kernel patches can be applied on top of the mainline kernel
(commit 37cb8e1f8) and https://patchwork.kernel.org/patch/10013259/.

I would also like to ask if it is fine to take code from the kernel without
including the original file. I tried to reuse as much code as possible, to
avoid two different implementations for kernel space and user space.

Thanks

Roberto


Roberto Sassu (5):
  digest-list-tools: headers
  digest-list-tools: library
  digest-list-tools: tools
  digest-list-tools: documentation
  digest-list-tools: package

-- 
2.11.0
