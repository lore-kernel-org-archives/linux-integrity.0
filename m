Return-Path: <SRS0=36rA=4W=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897B2C3F2CD
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60948208C3
	for <linux-integrity@archiver.kernel.org>; Thu,  5 Mar 2020 11:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCELU0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:20:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:14882 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgCELU0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Mar 2020 06:20:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 03:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,517,1574150400"; 
   d="scan'208";a="240786483"
Received: from unknown (HELO jsakkine-mobl1) ([10.237.50.161])
  by orsmga003.jf.intel.com with ESMTP; 05 Mar 2020 03:20:22 -0800
Message-ID: <deab5eab2de31a1116e16e025c94fbc6f1d0d742.camel@linux.intel.com>
Subject: Re: [PATCH v6 0/3] Enable vTPM 2.0 for the IBM vTPM driver
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Date:   Thu, 05 Mar 2020 13:20:23 +0200
In-Reply-To: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
References: <20200304132243.179402-1-stefanb@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.35.92-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-03-04 at 08:22 -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
> This series of patches enables vTPM 2.0 support for the IBM vTPM driver.

BTW, what is PAPR vTPM device model? Is it something that is used
generally for vTPM's or just in IBM context?

/Jarkko

