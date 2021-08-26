Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC89C432BE
	for <linux-integrity@archiver.kernel.org>; Thu, 26 Aug 2021 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3703860FD9
	for <linux-integrity@archiver.kernel.org>; Thu, 26 Aug 2021 16:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbhHZQMf (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 26 Aug 2021 12:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234549AbhHZQMd (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 12:12:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78C8F6103A;
        Thu, 26 Aug 2021 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994306;
        bh=0AuOEzh2zQK4EKF7xRo7+zDUVpjpNWKWx4v0fJDzHEA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=cMRKkyPlryiE0JNkPoV71KfdFCsTVyhvkJ1YT2hxhIoAnbRXF390uO/6Qz6rDYR1+
         Z/dfejue2X4mmepBmyGtfbtp9ncDTG8BYx9tuZK0VYL4ziM4gIhQm0qfXKgMBqBrC5
         kIIlU0OWW9IbHHTR71JIvXQ+er555qo38MX/AmMddMiF0k4k1SMqUkM1WPXFlXaWRg
         FdkaNjoS+i+Daiqp6S7BmoC778gosPtVNqVb8fymSJ/iKCmS3vXVGw4YucZbviWpXg
         I+zojcTsS1Ve0u/O8xdsqfwkxAxSGBT/Mr/A3Y6EiEuz9oyRkBQ4gERhTV3wbsp5DT
         lolO64Qv9ZzWQ==
Message-ID: <d9228f9a49d944e8ed47bf8dc18bc86cadf59389.camel@kernel.org>
Subject: Re: [PATCH v2] tpm: tis: Kconfig: Add helper dependency on
 COMPILE_TEST
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>, peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 26 Aug 2021 19:11:43 +0300
In-Reply-To: <20210826011012.2772-1-caihuoqing@baidu.com>
References: <20210826011012.2772-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-26 at 09:10 +0800, Cai Huoqing wrote:
> COMPILE_TEST is helpful to find compilation errors in other platform(e.g.=
X86).
> In this case, the support of COMPILE_TEST is added, so this module could
> be compiled in other platform(e.g.X86), without ARCH_SYNQUACER configurat=
ion.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
